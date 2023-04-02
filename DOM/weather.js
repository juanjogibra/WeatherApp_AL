//let City = "Huelva";
//let country = "ES";
//let temp = 21.1;
//let description = "Sol intenso";

//let myImg = "https://raw.githubusercontent.com/juanjogibra/WeatherApp_AL/30ad6881723d56d5903fffb89780f275614be8de/DOM/icons/800.svg"

if (window.addEventListener) {
    window.addEventListener('load', Initialize, false); //W3C
} else {
    window.attachEvent('onload', Initialize); //IE
}



function Initialize(City, Country, temp, icon, description) {
    const markp = `${temp}<sup>°C</sup>`
    let url = `https://raw.githubusercontent.com/juanjogibra/WeatherApp_AL/30ad6881723d56d5903fffb89780f275614be8de/DOM/icons/${icon}.svg`
    const box = `<div class="container">
<div class="centered">
    <ul class="cities">
        <h2 class="city-name" style="text-align: center;">
            <span id="City">Huelva</span>
            <sup id="CountryPrefix" style="background-color: orangered;">ES</sup>
        </h2>
        <div id="Temp" class="city-temp" style="text-align: center;">21º</div>
        <figure>
            <img id="myImg" src="https://raw.githubusercontent.com/juanjogibra/WeatherApp_AL/30ad6881723d56d5903fffb89780f275614be8de/DOM/icons/800.svg" alt ="Image not loaded" class="center" />
            <figcaption id="Description" style="text-align: center;"></figcaption>
        </figure>
    </ul>
</div>
</div>`;
    document.body.innerHTML = box;

    document.getElementById("City").innerHTML = City;
    document.getElementById("CountryPrefix").innerHTML = Country;
    document.getElementById("Description").innerHTML = description;
    document.getElementById("Temp").innerHTML = markp;
    document.getElementById("myImg").src = url;
}



function Change (City, Country, temp, icon, description) {
    
    const markp = `${temp}<sup>°C</sup>`
    let url = `https://raw.githubusercontent.com/juanjogibra/WeatherApp_AL/30ad6881723d56d5903fffb89780f275614be8de/DOM/icons/${icon}.svg`


    document.getElementById("City").innerHTML = City;
    document.getElementById("CountryPrefix").innerHTML = Country;
    document.getElementById("Description").innerHTML = description;
    document.getElementById("Temp").innerHTML = markp;
    document.getElementById("myImg").src = url;
}

function getImagePath() {
    return "icons/sunny.svg";
}