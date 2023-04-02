controladdin "Weather"
{
    StartupScript = '.\DOM\start.js';
    Scripts = '.\DOM\weather.js';
    StyleSheets = '.\DOM\Style.css';


    HorizontalStretch = true;
    HorizontalShrink = true;
    RequestedHeight = 300;
    VerticalShrink = true;
    VerticalStretch = true;

    event Ready()


    procedure Initialize(weatherCity: Text; weatherCountry: Text; WeatherTemp: decimal; weatherIcon: Integer; weatherDescription: Text);

    procedure Change(weatherCity: Text; weatherCountry: Text; WeatherTemp: decimal; weatherIcon: Integer; weatherDescription: Text);
}