controladdin "Weather"
{
    StartupScript = '.\DOM\start.js';
    Scripts = '.\DOM\weather.js';
    StyleSheets = '.\DOM\Style.css';

    HorizontalStretch = true;
    HorizontalShrink = true;
    // MinimumWidth = 250;
   // MinimumHeight = 300;
    //MaximumWidth = 250;
    // MaximumHeight = 300;
    RequestedHeight = 300;
    //RequestedWidth = 250;
    VerticalShrink = true;
    VerticalStretch = true;

    event Ready()

    // procedure Initialize();
    procedure Initialize(weatherCity: Text; weatherCountry: Text; WeatherTemp: decimal; weatherIcon: Integer; weatherDescription: Text);
}