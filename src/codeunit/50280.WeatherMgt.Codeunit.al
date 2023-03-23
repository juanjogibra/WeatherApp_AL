codeunit 50280 "WeatherMgt"
{

    trigger OnRun()
    begin

    end;


    procedure GetCurrentWeather()
    var
        WeatherInbox: record WeatherInbox;
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        entryNo: Integer;
        LocationsArray : JsonArray;
        JsonObj, JsonObj2 : JsonObject;
        JToken: JsonToken;
        Path, Result : Text;
        TimezoneOffset: Duration;
        ResultDateTime : DateTime;
        TypeHelper: Codeunit "Type Helper";

    begin
        WeatherSetup.Get();
        WeatherSetup.TestField("API Key");
        WeatherSetup.TestField(Longitude);
        WeatherSetup.TestField(Latitude);

        Path := StrSubstNo('https://api.openweathermap.org/data/2.5/weather?lat=%1&lon=%2&appid=%3&units=metric', WeatherSetup.Latitude, WeatherSetup.Longitude, WeatherSetup."API Key");

        if not Client.Get(Path, Response) then
            exit;

        if not Response.IsSuccessStatusCode then
            exit;

        content := Response.Content;
        Content.ReadAs(Result);

        if not JsonObj.ReadFrom(Result) then
            exit;

        //ID JObject --> Generate Entry No and Insert Record

        JsonObj.Get('id', JToken);
        if not JToken.AsValue().IsNull then begin

            WeatherInbox.SetCurrentKey("Entry No.");
            if not WeatherInbox.FindLast() then begin
                WeatherInbox.Reset();
                WeatherInbox.Init();
                WeatherInbox."Entry No." := 1;
            end
            else begin
                entryNo := (WeatherInbox."Entry No.") + 1;
                Clear(WeatherInbox);
                WeatherInbox.Init();
                WeatherInbox."Entry No." := entryNo;
            end;

            WeatherInbox.WeatherId := JToken.AsValue().AsInteger();
            WeatherInbox.Insert();
        end;


        //Weather Array

        JsonObj.Get('weather', JToken);
        LocationsArray := JToken.AsArray();

        LocationsArray.Get(0, JToken);

        //Weather JObject

        JsonObj2 := JToken.AsObject();

        JsonObj2.Get('main', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate("Weather Main", JToken.AsValue().AsText());

        JsonObj2.Get('description', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate("Weather Description", JToken.AsValue().AsText());

        //Main JObject

        JsonObj.Get('main', JToken);
        JsonObj2 := JToken.AsObject();

        JsonObj2.Get('temp', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate(Temperature, JToken.AsValue().AsDecimal());

        JsonObj2.Get('feels_like', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate("Feel Temperature", JToken.AsValue().AsDecimal());

        JsonObj2.Get('temp_min', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate("Min Temperature", JToken.AsValue().AsDecimal());

        JsonObj2.Get('temp_max', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate("Max Temperature", JToken.AsValue().AsDecimal());

        JsonObj2.Get('pressure', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate(Pressure, JToken.AsValue().AsDecimal());

        JsonObj2.Get('humidity', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate(Humidity, JToken.AsValue().AsDecimal());

        //Base JObject

        JsonObj.Get('base', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate(Base, JToken.AsValue().AsText());

        //Visibility JObject

        JsonObj.Get('visibility', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate(Visibility, JToken.AsValue().AsDecimal());

        //Wind JObject

        JsonObj.Get('wind', JToken);
        JsonObj2 := JToken.AsObject();

        JsonObj2.Get('speed', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate("Wind Speed", JToken.AsValue().AsDecimal());

        JsonObj.Get('timezone', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate(Timezone, JToken.AsValue().AsInteger());

        //Sys JObject

        JsonObj.Get('sys', JToken);
        JsonObj2 := JToken.AsObject();

        JsonObj2.Get('sunrise', JToken);
        if not JToken.AsValue().IsNull then begin
            ResultDateTime := TypeHelper.EvaluateUnixTimestamp(JToken.AsValue().AsBigInteger());
            WeatherInbox.Validate(Sunrise, DT2Time(ResultDateTime));
        end;

        JsonObj2.Get('sunset', JToken);
        if not JToken.AsValue().IsNull then begin
            ResultDateTime := TypeHelper.EvaluateUnixTimestamp(JToken.AsValue().AsBigInteger());
            WeatherInbox.Validate(Sunset, DT2Time(ResultDateTime));
        end;

        //Cloud JObject

        JsonObj.Get('clouds', JToken);
        JsonObj2 := JToken.AsObject();

        JsonObj2.Get('all', JToken);
        if not JToken.AsValue().IsNull then
            WeatherInbox.Validate(Clouds, JToken.AsValue().AsInteger());

        //Fill record with Weather Setup Info

        WeatherInbox.Validate(Longitude, WeatherSetup.Longitude);
        WeatherInbox.Validate(latitude, WeatherSetup.latitude);
        WeatherInbox.Validate(county, WeatherSetup.county);
        WeatherInbox.Validate(country, WeatherSetup.country);
        WeatherInbox.Validate(city, WeatherSetup.city);

        WeatherInbox.Modify();
    end;


    procedure GetLocation()
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Path, Result : Text;
        LocationsArray: JsonArray;
        JToken: JsonToken;
        JsonObj: JsonObject;
        Content: HttpContent;
    begin
        WeatherSetup.Get();
        WeatherSetup.TestField("API Key");
        WeatherSetup.TestField(City);

        Path := StrSubstNo('http://api.openweathermap.org/geo/1.0/direct?q=%1&appid=%2', WeatherSetup.City, WeatherSetup."API Key");

        if not Client.Get(Path, Response) then
            exit;

        if not Response.IsSuccessStatusCode then
            exit;

        Content := Response.Content;
        Content.ReadAs(Result);

        LocationsArray.ReadFrom(Result);
        LocationsArray.Get(0, JToken);

        JsonObj := JToken.AsObject();

        JsonObj.Get('lat', JToken);
        if not JToken.AsValue().IsNull then
            WeatherSetup.Validate(Latitude, JToken.AsValue().AsDecimal());

        JsonObj.Get('lon', JToken);
        if not JToken.AsValue().IsNull then
            WeatherSetup.Validate(longitude, JToken.AsValue().AsDecimal());

        JsonObj.Get('country', JToken);
        if not JToken.AsValue().IsNull then
            WeatherSetup.Validate(Country, JToken.AsValue().AsText());

        JsonObj.Get('state', JToken);
        if not JToken.AsValue().IsNull then
            WeatherSetup.Validate(County, JToken.AsValue().AsText());

        WeatherSetup.Validate(RequestDatetime, CurrentDateTime());

        WeatherSetup.Modify();
    end;


    var

        WeatherSetup: Record WeatherSetup;
}
