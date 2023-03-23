table 50281 "WeatherInbox"
{
    Caption = 'Weather Inbox', comment = 'ESP="Buzón clima"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.', comment = 'ESP="Nº registro"';
            DataClassification = CustomerContent;
        }
        field(2; WeatherId; Integer)
        {
            Caption = 'Weather Id', comment = 'ESP="Id. consulta tiempo"';
            DataClassification = ToBeClassified;
        }
        field(3; Latitude; Decimal)
        {
            Caption = 'Latitude', comment = 'ESP="Latitud"';
            DataClassification = CustomerContent;
        }
        field(4; Longitude; Decimal)
        {
            Caption = 'Longitude', comment = 'ESP="Longitud"';
            DataClassification = CustomerContent;
        }
        field(5; Country; Code[10])
        {
            Caption = 'Country', comment = 'ESP="País"';
            DataClassification = CustomerContent;
        }
        field(6; County; Text[50])
        {
            Caption = 'County', comment = 'ESP="Región"';
            DataClassification = CustomerContent;
        }
        field(7; City; Text[50])
        {
            Caption = 'City', comment = 'ESP="Ciudad"';
            DataClassification = CustomerContent;
        }
        field(11; "Weather Main"; Text[50])
        {
            Caption = 'Weather Main', comment = 'ESP="Tiempo"';
            DataClassification = CustomerContent;
        }
        field(12; "Weather Description"; Text[100])
        {
            Caption = 'Weather Description', comment = 'ESP="Descripción tiempo"';
            DataClassification = CustomerContent;
        }
        field(13; Base; Text[50])
        {
            Caption = 'Base', comment = 'ESP="Base"';
            DataClassification = CustomerContent;
        }
        field(14; Temperature; Decimal)
        {
            Caption = 'Temperature', comment = 'ESP="Temperatura"';
            DataClassification = CustomerContent;
        }
        field(15; "Feel Temperature"; Decimal)
        {
            Caption = 'Feel Temperature', comment = 'ESP="Sensación térmica"';
            DataClassification = CustomerContent;
        }
        field(16; "Min Temperature"; Decimal)
        {
            Caption = 'Min Temperature', comment = 'ESP="Temp. Mínima"';
            DataClassification = CustomerContent;
        }
        field(17; "Max Temperature"; Decimal)
        {
            Caption = 'Max Temperature', comment = 'ESP="Temp Máxima"';
            DataClassification = CustomerContent;
        }
        field(18; Pressure; Decimal)
        {
            Caption = 'Pressure', comment = 'ESP="Presión Atm."';
            DataClassification = CustomerContent;
        }
        field(19; Humidity; Decimal)
        {
            Caption = 'Humidity', comment = 'ESP="Humedad"';
            DataClassification = CustomerContent;
        }
        field(20; Visibility; Decimal)
        {
            Caption = 'Visibility', comment = 'ESP="Visibilidad"';
            DataClassification = CustomerContent;
        }
        field(21; "Wind Speed"; Decimal)
        {
            Caption = 'Wind Speed', comment = 'ESP="Velocidad del viento"';
            DataClassification = CustomerContent;
        }
        field(22; Timezone; Integer)
        {
            Caption = 'Timezone', comment = 'ESP="Zona horaria"';
            DataClassification = CustomerContent;
        }
        field(23; Clouds; Integer)
        {
            Caption = 'Clouds', comment = 'ESP="Nubes"';
            DataClassification = CustomerContent;
        }
        field(24; Sunrise; time)
        {
            Caption = 'Sunrise', comment = 'ESP="Amanecer"';
            DataClassification = CustomerContent;
        }
        field(25; Sunset; Time)
        {
            Caption = 'Sunset', comment = 'ESP="Puesta de sol"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
