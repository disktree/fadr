package fadr.chrome;

typedef SettingsData = { > fadr.FadrSettings,
    var idleTimeout : Null<Int>;
    var power : chrome.Power.Level;
}
