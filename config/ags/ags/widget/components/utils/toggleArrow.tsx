import { Variable } from "astal"

export default function ToggleArrow() {
    const rotating = Variable<boolean>(false)
    const arrow_open = Variable<boolean>(false)
    const css = Variable<string>("")
    let interval: any
    var deg = 0

    function rotateArrow() {
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
        arrow: () => <icon icon={"Arrow-symbolic"} css={css()} />,
        rotateArrow,
        arrow_open,
    }
}