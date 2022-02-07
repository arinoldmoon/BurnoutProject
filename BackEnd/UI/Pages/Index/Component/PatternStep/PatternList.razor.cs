using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using Radzen.Blazor;
using UI.Models;
using UI.Services;

namespace UI.Pages.Index.Component.PatternStep
{
    public partial class PatternListComponent : ComponentBase
    {
        [Inject]
        protected DialogService DialogService { get; set; }

        [Inject]
        protected PatternService Service { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }

        public IEnumerable<Pattern> PatternList { get; set; }

        protected RadzenDataGrid<Pattern> grid;

        public bool isLoading = false;

        public IList<Pattern> Selected { get; set; }

        protected async Task btnLoadClick(MouseEventArgs args)
        {
            int PatternNumber = Selected[0].PatternNumber;
            var response = await Service.GetPatternByID(PatternNumber);            
            
            Globals.GlobalPattern = new Pattern();
            Globals.GlobalPattern = response;

            DialogService.Close(null);
        }

        public async Task GetPatternList(LoadDataArgs args)
        {
            IEnumerable<Pattern> Result = new List<Pattern>();
            if (Globals.ServiceConnected)
            {
                Result = await Service.GetPatternListAsync();
                if (Result.Any())
                {
                    PatternList = Result;
                }
            }
        }
    }
}