# WeatherApp_AL
Weather App register in AL Code


Version 1.0.0.1:

Exist a Page where we can get the current Weather through an action (free acount let only 100 request per day)

Is a List type page where the new records will be showed

![image](https://user-images.githubusercontent.com/44053146/227203057-c3d2010d-7796-4695-99d3-74f6791e9c1d.png)



So, before launch the requests, you might considering to Set up the Weather settings. For that, we´ll move to Page Weather Setup from here (or from the search bar) 
![image](https://user-images.githubusercontent.com/44053146/227203005-e743fcb7-fcbc-4b5d-82e2-2666b4a20acf.png)


 It´s neccesary to fill the City and the API Key to obtain the Location. It´s important, because Latitude and Longitude are neccesaries to GET the current weather, and the request will not found without it
 
 ![image](https://user-images.githubusercontent.com/44053146/227202416-135f976d-f4e2-447e-85f4-60dbde57e72b.png)

Put Get Location, and the Latitude-Logitude fields will be filled

![image](https://user-images.githubusercontent.com/44053146/227202567-31ed7e6f-8d65-4363-bbfc-b1f98dcae488.png)


Now, you can to get the current weather

![image](https://user-images.githubusercontent.com/44053146/227203176-ec0297dc-63d8-44dd-93b0-bc46b64a55eb.png)





CHANGES V.2 


Now, he have a Widget in our Weather Inbox list and the Business manager Role Center which it will change depends of the selected record



<img width="889" alt="image" src="https://user-images.githubusercontent.com/44053146/229366610-4c4d0a24-6d9b-4919-ad25-e6d7cbf0d81e.png">



This Widget are made of Javascript and have been introduced in Business central though of a Conrol Addin in a Factbox (https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-control-addin-object) 


You can find this development in the project, and see how we can create the Widget and show in BC thanks to the Control Addin Properties and a bit of imagination :) 


I hope you enjoy!
