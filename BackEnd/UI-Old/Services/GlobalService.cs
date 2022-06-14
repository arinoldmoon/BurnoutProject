using System;
using System.Collections.Generic;
using UI.Models;

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

        MachineMonitor _GlobalMonitor;
        public MachineMonitor GlobalMonitor
        {
            get
            {
                return _GlobalMonitor;
            }
            set
            {
                if (!object.Equals(_GlobalMonitor, value))
                {
                    var args = new PropertyChangedEventArgs() { Name = "GlobalMonitor", NewValue = value, OldValue = _GlobalMonitor, IsGlobal = false };
                    _GlobalMonitor = value;
                    PropertyChanged?.Invoke(args);
                }
            }
        }

        private Pattern _GlobalPattern;
        public Pattern GlobalPattern
        {
            get
            {
                return _GlobalPattern;
            }
            set
            {
                if (!object.Equals(_GlobalMonitor, value))
                {
                    var args = new PropertyChangedEventArgs() { Name = "GlobalPattern", NewValue = value, OldValue = _GlobalPattern, IsGlobal = true };
                    _GlobalPattern = value;
                    PropertyChanged?.Invoke(args);
                }
            }
        }

        private MachineInfo _MachineInfo;
        public MachineInfo GlobalMachineInfo
        {
            get { return _MachineInfo; }
            set
            {
                if (!object.Equals(_MachineInfo, value))
                {
                    var args = new PropertyChangedEventArgs() { Name = "MachineInfo", NewValue = value, OldValue = _MachineInfo, IsGlobal = true };
                    _MachineInfo = value;
                    PropertyChanged?.Invoke(args);
                }
            }
        }
        
        private List<PatternItem> _SetPoint;
        public List<PatternItem> SetPoint
        {
            get { return _SetPoint; }
            set
            {
                if (!object.Equals(_SetPoint, value))
                {

                    var args = new PropertyChangedEventArgs() { Name = "SetPoint", NewValue = value, OldValue = _SetPoint, IsGlobal = true };

                    _SetPoint = value;
                    PropertyChanged?.Invoke(args);
                }
            }
        }

        private List<OperationLog> _ActualPoint;
        public List<OperationLog> ActualPoint
        {
            get { return _ActualPoint; }
            set
            {
                if (!object.Equals(_ActualPoint, value))
                {

                    var args = new PropertyChangedEventArgs() { Name = "ActualPoint", NewValue = value, OldValue = _ActualPoint, IsGlobal = true };

                    _ActualPoint = value;
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