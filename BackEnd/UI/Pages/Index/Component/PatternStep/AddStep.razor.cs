using System;
using System.ComponentModel;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using UI.Models;

namespace UI.Pages.Index.Component.PatternStep
{
    public partial class AddStepComponent : ComponentBase
    {

        [Parameter]
        public int RowIndex { get; set; }

        [Inject]
        protected DialogService DialogService { get; set; }

        [Inject]
        protected NotificationService NotificationService { get; set; }

        protected PatternItem Pattern { get; set; }

        protected override void OnInitialized()
        {
            Pattern = new PatternItem();
            Pattern.Step = RowIndex;
            Pattern.Temp = 30;
            Pattern.StepDuration = 30;
        }

       

        protected void FormSubmit(PatternItem args)
        {
            try
            {
                DialogService.Close(args);

            }
            catch (Exception sampleCreateProductException)
            {
                NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"Error", Detail = $"{sampleCreateProductException}" });
            }
        }

        protected void Close(MouseEventArgs args)
        {
            DialogService.Close(null);
        }

    }
}