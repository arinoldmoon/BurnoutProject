
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using UI.Models;
using UI.Protos;
using UI.Services;

namespace UI.Pages.Index.Component.Controller
{
    public partial class GraphSettingComponent : ComponentBase
    {
        [Inject]
        protected GlobalService Globals { get; set; }
        [Inject]
        protected PatternService patternService { get; set; }
        [Inject]
        protected OperationService operationService { get; set; }

        protected List<OvenLogList> LogList { get; set; } = new List<OvenLogList>();
        protected List<int> YearList { get; set; } = new List<int>();
        protected List<int> MonthList { get; set; } = new List<int>();

        public int SelectYear = 0;
        public int SelectMonth = 0;

        protected OvenLogList Selected;

        public async Task PlotChart(MouseEventArgs args)
        {
            Globals.ActualPoint = new List<OperationLog>();
            Globals.SetPoint = new List<PatternItem>();
            
            List<OperationLog> actual = await operationService.GetOperationLog(Selected.LogID);
            Pattern setpoint = (Selected.PatternID != 0 && Selected.PatternID != 99) ? await patternService.GetPatternByID(Selected.PatternID) : new Pattern();

            Globals.ActualPoint = actual;
            Globals.SetPoint = setpoint.PatternItems.ToList();

            StateHasChanged();
        }
        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "MachineInfo")
            {
                SetValue();
            }

            StateHasChanged();
        }

        protected override void OnAfterRender(bool firstRender)
        {
            if (firstRender)
            {                
                SetValue();
                StateHasChanged();
            }
        }

        public void SetValue()
        {
            if (Globals.GlobalMachineInfo != null)
            {
                YearList = Globals.GlobalMachineInfo.LogHeader.YearList;
                MonthList = Globals.GlobalMachineInfo.LogHeader.MonthList;
                LogList = Globals.GlobalMachineInfo.LogHeader.LogList.ToList();

                Selected = Globals.GlobalMachineInfo.LogHeader.LogList.First();
            }
        }

        protected override async Task OnInitializedAsync()
        {
            await base.OnInitializedAsync();
            Globals.PropertyChanged += OnPropertyChanged;            
        }
    }
}