page 50282 "WeatherPage"
{
    ApplicationArea = All;
    Caption = 'WeatherPage';
    PageType = CardPart;
    SourceTable = WeatherInbox;

    layout
    {
        area(content)
        {
            usercontrol(Weather; Weather)
            {
                ApplicationArea = All;
                trigger Ready()
                var
                    htmlText: Text;
                    WeatherInbox: Record WeatherInbox;
                begin
                    if not WeatherInbox.FindLast() then
                        exit;

                    CurrPage.Weather.Initialize(WeatherInbox.City, WeatherInbox.Country, WeatherInbox.Temperature, WeatherInbox."Icon Id", WeatherInbox."Weather Description");
                    //  CurrPage.Weather.Initialize(Rec.City, Rec.Country, Rec.Temperature, Rec."Icon Id", Rec."Weather Description");
                end;
            }
        }
    }
}
