global function GiftHarvesterInit
global function GiftHarvesterFocused
global function GiftHarvesterUnfocused
global function SwitchGiftOpenStatus


struct {
    bool focused
    bool pressed

    float waitSecs = 0.2
    bool isOpen = false


    array<int> btns = [
        KEY_ENTER
    ]
} file


void function GiftHarvesterInit(){
    // WaitFrame()

    file.focused = false
    file.pressed = false

    file.waitSecs = GetConVarFloat("gift_harvester_time_span") > 0 ? GetConVarFloat("gift_harvester_time_span") : 0.2

    // RegisterButtonsPressedCallback()

    thread Monitor()
}


// 只有在游戏对局内才会工作
// void function RegisterButtonsPressedCallback() {
//     foreach (int btn in file.btns) {
//         RegisterButtonPressedCallback( btn, void function (entity player) {
//             print("got pressed")
//             file.pressed = true
//         } )
//         RegisterButtonReleasedCallback( btn, void function (entity player) {
//             print("got released")
//             file.pressed = false
//         } )
//     }
// }

void function SwitchGiftOpenStatus() {
    // print("file.leftCount++")
    file.isOpen = !file.isOpen
}

void function GiftHarvesterFocused()
{
    file.focused = true
}

void function GiftHarvesterUnfocused()
{
    file.focused = false
    file.isOpen = false
}

void function Monitor(){
    WaitFrame()
    while(true)
    {
        WaitFrame()
        // if (file.focused && file.pressed) {
        if (file.focused && file.isOpen) {
            // GetLocalClientPlayer().ClientCommand( "UnlockRandomLoot" )
            // EmitUISound( "Menu_AdvocateGift_Open" )

            // RunUIScript( "ClientCommand", "UnlockRandomLoot" )
            // RunUIScript( "EmitUISound", "Menu_AdvocateGift_Open" )
            RunUIScript( "OpenAdvocateGift")
            wait file.waitSecs
        }
    }
}


