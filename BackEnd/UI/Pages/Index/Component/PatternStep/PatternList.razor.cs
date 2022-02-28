using System;
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
        protected DialogService DialogServices { get; set; }

        [Inject]
        protected PatternService Service { get; set; }

        [Inject]
        protected NotificationService NotificationService { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }

        public IEnumerable<Pattern> PatternList { get; set; }

        protected RadzenDataGrid<Pattern> grid;

        public bool isLoading = false;

        public IList<Pattern> Selected { get; set; }

        protected async Task btnLoadClick(MouseEventArgs args)
        {
            int PatternNumber = Selected[0].PatternNumber;
            Pattern response = await Service.GetPatternByID(PatternNumber);

            if (response != null)
            {
                Globals.GlobalPattern = response;
            }
            else
            {
                NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"PatternList", Detail = $"Load Failed" });
            }

            DialogServices.Close(null);
        }

        public async Task GetPatternList(LoadDataArgs args)
        {
            List<Pattern> Result = new List<Pattern>();
            if (Globals.ServiceConnected)
            {
                Result = (await Service.GetPatternListAsync()).ToList();

                if (Result.Any())
                {
                    PatternList = Result;
                }
                else
                {
                    NotificationService.Notify(NotificationSeverity.Error, "GetPatternList", "Empty List");
                }
            }
        }

        public async Task DeleteRow(Pattern pattern)
        {
            if (await DialogServices.Confirm("Are you sure you want to delete this pattern?") == true)
            {
                if (Globals.ServiceConnected)
                {                  
                    if (await Service.DeletePattern(pattern.PatternNumber))
                    {
                        NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Delete Pattern", Detail = $"Success" });
                        PatternList = (await Service.GetPatternListAsync()).ToList();
                    }
                    else
                    {
                        NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"Delete Pattern", Detail = $"Not Success" });
                        DialogServices.Dispose();
                    }
                }
            }
        }
    }
}