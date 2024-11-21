import { Variable } from "astal"

export default function Hexagon() {
    const rotating = Variable<boolean>(false)
    const hexagon_open = Variable<boolean>(false)
    const css = Variable<string>("")
    let interval: any
    var deg = 0

    function rotateHexagon() {
        let delay = 3
        if (!rotating().get() && deg < 90) {
            rotating.set(true)
            interval = setInterval(()=>{
                    deg += 1
                    css.set(`-gtk-icon-transform: rotate(${deg}deg);`)
                    if (deg >= 90) {
                        clearInterval(interval)
                        rotating.set(false)
                        hexagon_open.set(true)
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
                        hexagon_open.set(false)
                    }
            }, delay)
        }
    }
    return {
        render: () => <icon icon={"Hexagon2-symbolic"} css={css()} />,
        rotateHexagon,
        hexagon_open,
    };
}