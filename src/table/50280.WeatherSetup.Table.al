table 50280 "WeatherSetup"
{
    Caption = 'Weather Setup', comment = 'ESP="Conf. Clima"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            Caption = 'Primary Key', comment = 'ESP="Clave primaria"';
            DataClassification = CustomerContent;
        }
        field(2; "API Key"; Text[50])
        {
            Caption = 'API Key', comment = 'ESP="Clave API"';
            DataClassification = CustomerContent;
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
        field(100; RequestDatetime; DateTime)
        {
            Caption = 'Request Datetime', comment = 'ESP="Fecha ult. petición"';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
