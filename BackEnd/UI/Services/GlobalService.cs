using System;

namespace UI.Services
{
    public partial class GlobalService
    {
        public event Action<PropertyChangedEventArgs> PropertyChanged;

        bool _ServiceConnected;
        public bool ServiceConnected
        {
            get
            {
                return _ServiceConnected;
            }
            set
            {
                if (!object.Equals(_ServiceConnected, value))
                {
                    var args = new PropertyChangedEventArgs() { Name = "ServiceConnected", NewValue = value, OldValue = _ServiceConnected, IsGlobal = true };
                    _ServiceConnected = value;
                    PropertyChanged?.Invoke(args);
                }
            }
        }

        bool _PlcConnected;
        public bool PlcConnected
        {
            get
            {
                return _PlcConnected;
            }
            set
            {
                if (!object.Equals(_PlcConnected, value))
                {
                    var args = new PropertyChangedEventArgs() { Name = "PlcConnected", NewValue = value, OldValue = _PlcConnected, IsGlobal = true };
                    _PlcConnected = value;
                    PropertyChanged?.Invoke(args);
                }
            }
        }
    }

    public class PropertyChangedEventArgs
    {
        public string Name { get; set; }
        public object NewValue { get; set; }
        public object OldValue { get; set; }
        public bool IsGlobal { get; set; }
    }
}