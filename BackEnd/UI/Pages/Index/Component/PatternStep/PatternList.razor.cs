using GrpcService.Protos;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using Radzen.Blazor;
using UI.Services;

namespace UI.Pages.Index.Component.PatternStep
{
    public partial class PatternListComponent : ComponentBase
    {
        [Inject]
        protected DialogService? _dialogServices { get; set; }

        [Inject]
        protected PatternService? _patternService { get; set; }

        [Inject]
        protected NotificationService? _notificationService { get; set; }

        [Inject]
        protected GlobalService? _globals { get; set; }

        protected RadzenDataGrid<ProtoPattern>? _dataGrid;
        protected IEnumerable<ProtoPattern>? _patternList { get; set; }
        protected IList<ProtoPattern> Selected { get; set; } = new List<ProtoPattern>();

        protected Task btnLoadClick(MouseEventArgs args)
        {
            return Task.Run(async () => await _patternService!.GetPatternByID(Selected.First().PatternId)).ContinueWith(res =>
            {
                if (res.Result != null)
                {
                    _globals!.GlobalPattern = res.Result;
                    _globals.SetPoint = res.Result.PatternDetail.ToList();
                }
                else
                {
                    _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"PatternList", Detail = $"Load Failed" });
                }

                _dialogServices!.Close(null);
            });
        }

        protected Task LoadData(LoadDataArgs args)
        {
            if (_globals!.ServiceConnected)
            {
                return Task.Run(async () => await _patternService!.GetPatternListAsync()).ContinueWith(res =>
                {
                    if (res.Result.Any())
                    {
                        _patternList = res.Result.ToList();
                        Selected = _patternList.Take(1).ToList();
                    }
                    else
                    {
                        _notificationService!.Notify(NotificationSeverity.Error, "GetPatternList", "Empty List");
                    }
                });
            }

            return Task.CompletedTask;
        }

        protected Task DeleteRow(ProtoPattern pattern)
        {
            return Task.Run(async () => await _dialogServices!.Confirm("Are you sure you want to delete this pattern?")).ContinueWith(res =>
            {
                if (res.Result!.Value)
                {
                    if (_globals!.ServiceConnected)
                    {
                        Task.Run(async () => await _patternService!.DeletePattern(pattern.PatternId)).ContinueWith(res =>
                        {
                            if (res.Result.Value)
                            {
                                Task.Run(async () => await _patternService!.GetPatternListAsync()).ContinueWith(res =>
                                 {
                                     _patternList = res.Result.ToList();                                     
                                     _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Delete Pattern", Detail = $"Success" });
                                     InvokeAsync(StateHasChanged);
                                 });
                            }
                            else
                            {
                                _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"Delete Pattern", Detail = $"Not Success" });
                                _dialogServices!.Dispose();
                            }
                        });
                    }
                }
            });           
        }
    }
}