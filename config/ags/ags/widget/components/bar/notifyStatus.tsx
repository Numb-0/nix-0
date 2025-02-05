import { bind } from 'astal';
import Notifd from 'gi://AstalNotifd';


export default function NotifyStatus(){
    const notify = Notifd.get_default();

    return <box cssClasses={["notify"]}>
        <button onClicked={() => notify.dontDisturb = !notify.dontDisturb}> 
            <image iconName={bind(notify, "dontDisturb").as(d => d ? "notification-disabled-symbolic" : "notification-symbolic")} />
        </button>
    </box>
}
