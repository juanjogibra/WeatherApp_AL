page 50281 "WeatherInboxList"
{
    ApplicationArea = All;
    Caption = 'Weather Inbox List', comment = 'ESP="Buzón clima Lista"';
    PageType = List;
    SourceTable = WeatherInbox;
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field(WeatherId; Rec.WeatherId)
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = all;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = all;
                }
                field("Weather Main"; Rec."Weather Main")
                {
                    ApplicationArea = all;
                }
                field("Weather Description"; Rec."Weather Description")
                {
                    ApplicationArea = all;
                }
                field(Temperature; Rec.Temperature)
                {
                    ApplicationArea = all;
                }
                field("Feel Temperature"; Rec."Feel Temperature")
                {
                    ApplicationArea = all;
                }
                field("Min Temperature"; Rec."Min Temperature")
                {
                    ApplicationArea = all;
                }
                field("Max Temperature"; Rec."Max Temperature")
                {
                    ApplicationArea = all;
                }
                field(Pressure; Rec.Pressure)
                {
                    ApplicationArea = all;
                }
                field("Wind Speed"; Rec."Wind Speed")
                {
                    ApplicationArea = all;
                }
                field(Humidity; Rec.Humidity)
                {
                    ApplicationArea = all;
                }
                field(Visibility; Rec.Visibility)
                {
                    ApplicationArea = all;
                }
                field(Clouds; Rec.Clouds)
                {
                    ApplicationArea = all;
                }
                field(Sunrise; Rec.Sunrise)
                {
                    ApplicationArea = all;
                }
                field(Sunset; Rec.Sunset)
                {
                    ApplicationArea = all;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GetCurrentWeather)
            {
                ApplicationArea = all;
                Caption = 'Get current Weather', comment = 'ESP="Obtener clima actual"';
                Image = Cloud;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    WeatherMgt: Codeunit WeatherMgt;
                begin
                    WeatherMgt.GetCurrentWeather();
                end;
            }
        }
        area(Navigation)
        {
            action(GoToSettings)
            {
                ApplicationArea = all;
                Caption = 'Go to settings', comment = 'ESP="Ir a Configuración"';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page WeatherSetup;
            }
        }
    }
}