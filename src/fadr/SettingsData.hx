package fadr;

typedef SettingsData = {

    var fadeDuration : Int;
    var changeInterval : Int;

    var brightness : Int;
    var saturation : Int;

    #if chrome
    var idleTimeout : Int;
    //var powerLevel : chrome.Power.Level;
    #end
}
