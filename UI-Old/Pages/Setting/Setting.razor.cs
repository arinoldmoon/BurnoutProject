using System;
using Microsoft.AspNetCore.Components;
using UI.Services;

namespace UI.Pages.Setting
{
    public partial class SettingComponent : ComponentBase, IDisposable
    {
        [Inject]
        protected GlobalService Globals { get; set; }

        private void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "GlobalPattern")
            {
                Reload();
            }
        }

        public void Dispose()
        {
            Globals.PropertyChanged -= OnPropertyChanged;
        }

        protected override void OnInitialized()
        {
            Globals.PropertyChanged += OnPropertyChanged;
        }
        
    }
}