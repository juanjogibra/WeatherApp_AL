codeunit 50280 "WeatherMgt"
{

    trigger OnRun()
    begin

    end;


    procedure GetCurrentWeather()
    var
        WeatherInbox: record WeatherInbox;
        TypeHelper: Codeunit "Type Helper";
        ResultDateTime: DateTime;
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        entryNo: Integer;
        LocationsArray: JsonArray;
        JsonObj, JsonObj2 : JsonObject;
        JToken: JsonToken;
        Path, Result : Text;

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
        if (JsonObj.Get('id', JToken)) and (not JToken.AsValue().IsNull) then begin
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
        if JsonObj.Get('weather', JToken) then
            LocationsArray := JToken.AsArray();

        if LocationsArray.Get(0, JToken) then begin
            //Weather JObject
            JsonObj2 := JToken.AsObject();

            if (JsonObj2.Get('main', JToken)) and (not JToken.AsValue().IsNull) then
                WeatherInbox.Validate("Weather Main", JToken.AsValue().AsText());

            if (JsonObj2.Get('description', JToken)) and (not JToken.AsValue().IsNull) then
                WeatherInbox.Validate("Weather Description", JToken.AsValue().AsText());
        end;

        //Main JObject

        if JsonObj.Get('main', JToken) then
            JsonObj2 := JToken.AsObject();

        if (JsonObj2.Get('temp', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate(Temperature, JToken.AsValue().AsDecimal());

        if (JsonObj2.Get('feels_like', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate("Feel Temperature", JToken.AsValue().AsDecimal());

        if (JsonObj2.Get('temp_min', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate("Min Temperature", JToken.AsValue().AsDecimal());

        if (JsonObj2.Get('temp_max', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate("Max Temperature", JToken.AsValue().AsDecimal());

        if (JsonObj2.Get('pressure', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate(Pressure, JToken.AsValue().AsDecimal());

        if (JsonObj2.Get('humidity', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate(Humidity, JToken.AsValue().AsDecimal());

        //Base JObject

        if (JsonObj.Get('base', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate(Base, JToken.AsValue().AsText());

        //Visibility JObject

        if (JsonObj.Get('visibility', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate(Visibility, JToken.AsValue().AsDecimal());

        //Wind JObject

        if JsonObj.Get('wind', JToken) then
            JsonObj2 := JToken.AsObject();

        if (JsonObj2.Get('speed', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate("Wind Speed", JToken.AsValue().AsDecimal());

        if (JsonObj.Get('timezone', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherInbox.Validate(Timezone, JToken.AsValue().AsInteger());

        //Sys JObject

        if JsonObj.Get('sys', JToken) then
            JsonObj2 := JToken.AsObject();

        if (JsonObj2.Get('sunrise', JToken)) and (not JToken.AsValue().IsNull) then begin
            ResultDateTime := TypeHelper.EvaluateUnixTimestamp(JToken.AsValue().AsBigInteger());
            WeatherInbox.Validate(Sunrise, DT2Time(ResultDateTime));
        end;

        if (JsonObj2.Get('sunset', JToken)) and (not JToken.AsValue().IsNull) then begin
            ResultDateTime := TypeHelper.EvaluateUnixTimestamp(JToken.AsValue().AsBigInteger());
            WeatherInbox.Validate(Sunset, DT2Time(ResultDateTime));
        end;

        //Cloud JObject

        if JsonObj.Get('clouds', JToken) then
            JsonObj2 := JToken.AsObject();

        if (JsonObj2.Get('all', JToken)) and (not JToken.AsValue().IsNull) then
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
        Content: HttpContent;
        Response: HttpResponseMessage;
        LocationsArray: JsonArray;
        JsonObj: JsonObject;
        JToken: JsonToken;
        Path, Result : Text;
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

        if (JsonObj.Get('lat', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherSetup.Validate(Latitude, JToken.AsValue().AsDecimal());

        if (JsonObj.Get('lon', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherSetup.Validate(longitude, JToken.AsValue().AsDecimal());

        if (JsonObj.Get('country', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherSetup.Validate(Country, JToken.AsValue().AsText());

        if (JsonObj.Get('state', JToken)) and (not JToken.AsValue().IsNull) then
            WeatherSetup.Validate(County, JToken.AsValue().AsText());

        WeatherSetup.Validate(RequestDatetime, CurrentDateTime());

        WeatherSetup.Modify();
    end;


    var

        WeatherSetup: Record WeatherSetup;
}
