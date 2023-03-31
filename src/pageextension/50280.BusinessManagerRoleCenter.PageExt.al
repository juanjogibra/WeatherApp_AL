pageextension 50280 "BusinessManagerRoleCenter" extends "Business Manager Role Center"
{
    layout
    {
        addbefore(Control16)
        {
            part(WeatherPage; WeatherPage)
            {
                Caption = 'Current Weather', comment = 'ESP="Tiempo actual"';
                ApplicationArea = All;
            }
        }
    }
}