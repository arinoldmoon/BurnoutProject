using System;
using System.ComponentModel;

namespace UI.Services
{
    public class GlobalService
    {
        public event Action<PropertyChangedEventArgs> PropertyChanged;

    }

    public class PropertyChangedEventArgs
    {
        public string Name { get; set; }
        public object NewValue { get; set; }
        public object OldValue { get; set; }
        public bool IsGlobal { get; set; }
    }
}