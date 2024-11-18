import { Variable } from "astal"

const rotating = Variable<boolean>(false)
export const arrow_open = Variable<boolean>(false)
const css = Variable<string>("")
let interval: any
var deg = 0


export function rotateArrow() {
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

export default function ToggleArrow() {
    return <icon icon={"Playing-symbolic"} css={css()} />
}