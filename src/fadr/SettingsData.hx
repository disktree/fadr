package fadr;

typedef SettingsData = {

    var fadeDuration : Int;
    var changeInterval : Int;

    var brightness : Int;
    var saturation : Int;

    #if chrome
    //var screensaver : Bool;
    var powerLevel : chrome.Power.Level;
    var idleTimeout : Int;
    #end
}
