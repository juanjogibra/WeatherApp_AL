page 50280 "WeatherSetup"
{
    ApplicationArea = All;
    Caption = 'Weather Setup', comment = 'ESP="Conf. Clima"';
    PageType = Card;
    SourceTable = WeatherSetup;
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(WebService)
            {
                Caption = 'Web Service parameters', comment = 'ESP="Parámetros servicio Web"';

                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("API Key"; Rec."API Key")
                {
                    ApplicationArea = all;
                }
            }
            group(Response)
            {
                Caption = 'Response', comment = 'ESP="Respuesta"';

                field(Latitude; Rec.Latitude)
                {
                    ApplicationArea = all;
                }
                field(Longitude; Rec.Longitude)
                {
                    ApplicationArea = all;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(RequestDatetime; Rec.RequestDatetime)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetLocation)
            {
                ApplicationArea = all;
                Caption = 'Get Location', comment = 'ESP="Obtener localización"';
                Image = Map;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    WeatherMgt: Codeunit WeatherMgt;
                begin
                    WeatherMgt.GetLocation();
                end;
            }
        }
    }


    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
