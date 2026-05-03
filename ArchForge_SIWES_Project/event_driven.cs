
using System;
using System.Collections.Generic;

namespace ArchForge.EventDriven {
    public class UserCreated {
        public string UserId { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
    }

    public class EventBus {
        private readonly Dictionary<Type, List<Action<object>>> _handlers = new Dictionary<Type, List<Action<object>>>();

        public void Subscribe<T>(Action<T> handler) {
            var type = typeof(T);
            if (!_handlers.ContainsKey(type)) _handlers[type] = new List<Action<object>>();
            _handlers[type].Add(o => handler((T)o));
        }

        public void Publish<T>(T @event) {
            var type = typeof(T);
            if (_handlers.ContainsKey(type)) {
                foreach (var handler in _handlers[type]) handler(@event);
            }
        }
    }

    class Program {
        static void Main() {
            Console.WriteLine("ArchForge — Event-Driven Demo (C# 7.0)");
            var bus = new EventBus();
            bus.Subscribe<UserCreated>(e => Console.WriteLine($"[Notification] Welcome email sent to {e.Email}"));
            bus.Publish(new UserCreated { UserId = "123", Name = "Alice", Email = "alice@example.com" });
            Console.WriteLine("\u2705 Event-Driven demonstration complete!");
        }
    }
}
