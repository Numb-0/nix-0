import { Variable} from "astal"
import { App, hook} from "astal/gtk4"

export default function ToggleArrow(id: string) {
    const rotating = Variable<boolean>(false)
    const arrow_open = Variable<boolean>(false)
    const css = Variable<string>("")
    let interval: any
    var deg = 0


    function rotate_arrow() {
        let delay = 2
        if (!rotating().get() && deg < 90) {
            rotating.set(true)
            interval = setInterval(()=>{
                    deg += 1
                    css.set(`-gtk-icon-transform: rotate(${deg}deg);`)
                    if (deg >= 90) {
                        clearInterval(interval)
                        rotating.set(false)
                        arrow_open.set(true)
                    }
            }, delay)
        }else if (!rotating().get() && deg >= 90) {
            rotating.set(true)
            interval = setInterval(()=>{
                    deg -= 1
                    css.set(`-gtk-icon-transform: rotate(${deg}deg);`)
                    if (deg <= 0) {
                        clearInterval(interval)
                        rotating.set(false)
                        arrow_open.set(false)
                    }
            }, delay)
        }
    }

    return {
        arrow: <image
            setup={self=>hook(self, css(), () => App.apply_css(`.arrow${id} {${css().get()}}`))}
            cssClasses={[`arrow${id}`]} 
            iconName={"arrow-symbolic"}
            />,
        rotate_arrow,
        arrow_open,
    }
}