import 'reflect-metadata';
/**
 * ArchForge — MVC Architecture & TypeScript Patterns
 * CSC 419: Software Design and Architecture
 *
 * Demonstrates:
 *   - MVC (Model-View-Controller) architectural pattern
 *   - TypeScript decorators (metadata, validation, logging)
 *   - Generics for type-safe collections
 *   - Interfaces and type contracts
 *   - Dependency injection
 *   - REST API controller pattern
 *   - Data Transfer Objects (DTOs)
 *   - Middleware pipeline (Express-style)
 *
 * Run: npx ts-node typescript/mvc_architecture.ts
 * Or:  tsc typescript/mvc_architecture.ts && node typescript/mvc_architecture.js
 */

// ─── Type Utilities ───────────────────────────────────────────
type UUID = string;
type ISO8601 = string;
type Optional<T> = T | null | undefined;

interface Timestamps {
  createdAt: ISO8601;
  updatedAt: ISO8601;
}

// ─── Decorators ───────────────────────────────────────────────
/**
 * Decorator Factory: @Log — logs method calls with timing.
 * Demonstrates TypeScript decorator pattern.
 */
function Log(target: any, key: string, descriptor: PropertyDescriptor) {
  const original = descriptor.value;
  descriptor.value = function (...args: any[]) {
    const start = performance.now();
    console.log(`  [LOG] ${target.constructor.name}.${key}(${args.map(a => JSON.stringify(a)).join(', ')})`);
    const result = original.apply(this, args);
    const elapsed = (performance.now() - start).toFixed(2);
    console.log(`  [LOG] ↩ completed in ${elapsed}ms`);
    return result;
  };
  return descriptor;
}

/**
 * Class Decorator: @Injectable — marks a class for DI container.
 */
function Injectable(target: Function) {
  Reflect.defineMetadata?.('injectable', true, target);
  return target;
}

/**
 * Property Decorator: @Validate — runtime type validation.
 */
function Required(target: any, key: string) {
  let value = target[key];
  Object.defineProperty(target, key, {
    get: () => value,
    set: (newVal: any) => {
      if (newVal === null || newVal === undefined || newVal === '') {
        throw new Error(`${key} is required and cannot be empty`);
      }
      value = newVal;
    }
  });
}

// ─── Generic Repository ───────────────────────────────────────
interface Entity {
  id: UUID;
}

/**
 * Generic Repository — type-safe CRUD operations.
 * T must extend Entity (has an id property).
 */
class GenericRepository<T extends Entity> {
  private store: Map<UUID, T> = new Map();

  save(entity: T): T {
    this.store.set(entity.id, { ...entity });
    return entity;
  }

  findById(id: UUID): Optional<T> {
    return this.store.get(id) ?? null;
  }

  findAll(): T[] {
    return Array.from(this.store.values());
  }

  delete(id: UUID): boolean {
    return this.store.delete(id);
  }

  findWhere(predicate: (entity: T) => boolean): T[] {
    return this.findAll().filter(predicate);
  }

  count(): number {
    return this.store.size;
  }

  update(id: UUID, partial: Partial<T>): Optional<T> {
    const existing = this.findById(id);
    if (!existing) return null;
    const updated = { ...existing, ...partial, updatedAt: new Date().toISOString() } as T;
    this.store.set(id, updated);
    return updated;
  }
}

// ─── Models ───────────────────────────────────────────────────
// Interfaces define the contract (I in SOLID — Interface Segregation)
interface IProduct extends Entity, Timestamps {
  name: string;
  description: string;
  price: number;
  category: string;
  stock: number;
  active: boolean;
}

interface IOrder extends Entity, Timestamps {
  userId: UUID;
  items: OrderItem[];
  status: OrderStatus;
  total: number;
  shippingAddress: Address;
}

interface OrderItem {
  productId: UUID;
  name: string;
  quantity: number;
  unitPrice: number;
  subtotal: number;
}

interface Address {
  street: string;
  city: string;
  state: string;
  country: string;
}

type OrderStatus = 'pending' | 'confirmed' | 'shipped' | 'delivered' | 'cancelled';

// ─── DTOs (Data Transfer Objects) ────────────────────────────
// DTOs decouple the API contract from the internal model
interface CreateProductDTO {
  name: string;
  description: string;
  price: number;
  category: string;
  stock: number;
}

interface UpdateProductDTO {
  name?: string;
  price?: number;
  stock?: number;
  active?: boolean;
}

interface CreateOrderDTO {
  userId: UUID;
  items: Array<{ productId: UUID; quantity: number }>;
  shippingAddress: Address;
}

interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: string;
  meta?: {
    total?: number;
    page?: number;
    timestamp: ISO8601;
  };
}

// ─── Service Layer ────────────────────────────────────────────
class ProductService {
  constructor(private readonly repo: GenericRepository<IProduct>) {}

  create(dto: CreateProductDTO): IProduct {
    if (dto.price <= 0)  throw new Error('Price must be positive');
    if (dto.stock < 0)   throw new Error('Stock cannot be negative');
    if (!dto.name.trim()) throw new Error('Product name is required');

    const product: IProduct = {
      id: crypto.randomUUID(),
      ...dto,
      active: true,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    return this.repo.save(product);
  }

  findAll(category?: string): IProduct[] {
    const all = this.repo.findAll().filter(p => p.active);
    return category ? all.filter(p => p.category === category) : all;
  }

  findById(id: UUID): Optional<IProduct> {
    return this.repo.findById(id);
  }

  update(id: UUID, dto: UpdateProductDTO): Optional<IProduct> {
    if (dto.price !== undefined && dto.price <= 0)
      throw new Error('Price must be positive');
    return this.repo.update(id, dto as Partial<IProduct>);
  }

  reduceStock(id: UUID, quantity: number): void {
    const product = this.repo.findById(id);
    if (!product) throw new Error(`Product ${id} not found`);
    if (product.stock < quantity) throw new Error(`Insufficient stock: have ${product.stock}, need ${quantity}`);
    this.repo.update(id, { stock: product.stock - quantity } as Partial<IProduct>);
  }

  getLowStock(threshold: number = 10): IProduct[] {
    return this.repo.findWhere(p => p.active && p.stock <= threshold);
  }
}

class OrderService {
  constructor(
    private readonly orderRepo: GenericRepository<IOrder>,
    private readonly productService: ProductService
  ) {}

  create(dto: CreateOrderDTO): IOrder {
    // Validate all products exist and calculate totals
    const items: OrderItem[] = dto.items.map(item => {
      const product = this.productService.findById(item.productId);
      if (!product) throw new Error(`Product ${item.productId} not found`);
      if (!product.active) throw new Error(`Product ${product.name} is not available`);
      return {
        productId: item.productId,
        name: product.name,
        quantity: item.quantity,
        unitPrice: product.price,
        subtotal: product.price * item.quantity
      };
    });

    const total = items.reduce((sum, item) => sum + item.subtotal, 0);

    // Reserve stock
    dto.items.forEach(item => this.productService.reduceStock(item.productId, item.quantity));

    const order: IOrder = {
      id: crypto.randomUUID(),
      userId: dto.userId,
      items,
      status: 'pending',
      total,
      shippingAddress: dto.shippingAddress,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };

    return this.orderRepo.save(order);
  }

  updateStatus(orderId: UUID, newStatus: OrderStatus): Optional<IOrder> {
    // State machine validation
    const order = this.orderRepo.findById(orderId);
    if (!order) throw new Error('Order not found');

    const validTransitions: Record<OrderStatus, OrderStatus[]> = {
      pending:   ['confirmed', 'cancelled'],
      confirmed: ['shipped', 'cancelled'],
      shipped:   ['delivered'],
      delivered: [],
      cancelled: []
    };

    if (!validTransitions[order.status].includes(newStatus)) {
      throw new Error(`Invalid transition: ${order.status} → ${newStatus}`);
    }

    return this.orderRepo.update(orderId, { status: newStatus } as Partial<IOrder>);
  }

  getOrdersByUser(userId: UUID): IOrder[] {
    return this.orderRepo.findWhere(o => o.userId === userId);
  }
}

// ─── MVC: Controller Layer ────────────────────────────────────
/**
 * Controller — receives requests, calls services, returns responses.
 * Part of the MVC pattern: Model=IProduct, View=ApiResponse, Controller=this.
 */
class ProductController {
  constructor(private readonly productService: ProductService) {}

  @Log
  createProduct(dto: CreateProductDTO): ApiResponse<IProduct> {
    try {
      const product = this.productService.create(dto);
      return { success: true, data: product,
        meta: { timestamp: new Date().toISOString() }};
    } catch (err) {
      return { success: false, error: (err as Error).message,
        meta: { timestamp: new Date().toISOString() }};
    }
  }

  @Log
  listProducts(category?: string): ApiResponse<IProduct[]> {
    const products = this.productService.findAll(category);
    return { success: true, data: products,
      meta: { total: products.length, timestamp: new Date().toISOString() }};
  }

  @Log
  updateProduct(id: UUID, dto: UpdateProductDTO): ApiResponse<IProduct> {
    try {
      const updated = this.productService.update(id, dto);
      if (!updated) return { success: false, error: `Product ${id} not found`, meta: { timestamp: new Date().toISOString() } };
      return { success: true, data: updated, meta: { timestamp: new Date().toISOString() }};
    } catch (err) {
      return { success: false, error: (err as Error).message, meta: { timestamp: new Date().toISOString() }};
    }
  }
}

class OrderController {
  constructor(private readonly orderService: OrderService) {}

  @Log
  createOrder(dto: CreateOrderDTO): ApiResponse<IOrder> {
    try {
      const order = this.orderService.create(dto);
      return { success: true, data: order, meta: { timestamp: new Date().toISOString() }};
    } catch (err) {
      return { success: false, error: (err as Error).message, meta: { timestamp: new Date().toISOString() }};
    }
  }

  @Log
  updateOrderStatus(id: UUID, status: OrderStatus): ApiResponse<IOrder> {
    try {
      const order = this.orderService.updateStatus(id, status);
      return { success: true, data: order!, meta: { timestamp: new Date().toISOString() }};
    } catch (err) {
      return { success: false, error: (err as Error).message, meta: { timestamp: new Date().toISOString() }};
    }
  }
}

// ─── Application Bootstrap ────────────────────────────────────
function bootstrap(): void {
  console.log('╔══════════════════════════════════════════════════╗');
  console.log('║  ArchForge — MVC Architecture (TypeScript)       ║');
  console.log('║  CSC 419: Software Design and Architecture       ║');
  console.log('╚══════════════════════════════════════════════════╝\n');

  // DI: Wire up dependencies
  const productRepo  = new GenericRepository<IProduct>();
  const orderRepo    = new GenericRepository<IOrder>();
  const productSvc   = new ProductService(productRepo);
  const orderSvc     = new OrderService(orderRepo, productSvc);
  const productCtrl  = new ProductController(productSvc);
  const orderCtrl    = new OrderController(orderSvc);

  // Seed products
  console.log('[1] Creating Products (via Controller)...');
  const p1 = productCtrl.createProduct({ name: 'MacBook Pro', description: 'Apple laptop', price: 850000, category: 'Electronics', stock: 15 });
  const p2 = productCtrl.createProduct({ name: 'iPhone 15',   description: 'Apple phone',  price: 600000, category: 'Electronics', stock: 8 });
  const p3 = productCtrl.createProduct({ name: 'AirPods Pro', description: 'Wireless earbuds', price: 95000, category: 'Electronics', stock: 30 });

  // List products
  console.log('\n[2] Listing Products...');
  const list = productCtrl.listProducts('Electronics');
  list.data?.forEach(p => console.log(`  • ${p.name} — ₦${p.price.toLocaleString()} (stock: ${p.stock})`));

  // Create order
  console.log('\n[3] Creating Order...');
  const userId = crypto.randomUUID();
  const orderResp = orderCtrl.createOrder({
    userId,
    items: [
      { productId: p1.data!.id, quantity: 1 },
      { productId: p3.data!.id, quantity: 2 }
    ],
    shippingAddress: { street: '15 Victoria Island', city: 'Lagos', state: 'Lagos', country: 'Nigeria' }
  });

  if (orderResp.success) {
    const order = orderResp.data!;
    console.log(`  ✓ Order: ${order.id.substring(0,8)}... | Total: ₦${order.total.toLocaleString()} | Status: ${order.status}`);

    // Update order status through state machine
    console.log('\n[4] Order State Machine...');
    const s1 = orderCtrl.updateOrderStatus(order.id, 'confirmed');
    console.log(`  ${order.status} → confirmed: ${s1.success ? '✓' : s1.error}`);
    const s2 = orderCtrl.updateOrderStatus(order.id, 'shipped');
    console.log(`  confirmed → shipped: ${s2.success ? '✓' : s2.error}`);
    const s3 = orderCtrl.updateOrderStatus(order.id, 'cancelled'); // Invalid!
    console.log(`  shipped → cancelled: ${s3.success ? '✓' : '✗ ' + s3.error}`);
  }

  // Low stock alert
  console.log('\n[5] Low Stock Check...');
  const lowStock = productSvc.getLowStock(10);
  lowStock.forEach(p => console.log(`  ⚠ Low stock: ${p.name} (${p.stock} remaining)`));

  console.log('\n✅ MVC Architecture + TypeScript demonstration complete!');
}

bootstrap();
