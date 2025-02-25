import { bind, timeout } from "astal";
import { Gtk } from "astal/gtk4";
import Bluetooth from "gi://AstalBluetooth";
import ScrolledWindow from "../astalified/ScrolledWindow";

export default function BluetoothList() {
  const bluetooth = Bluetooth.get_default();

  // Custom icons for devices
  const custom_icons: { [key: string]: string } = {
    "audio-headset": "headset-symbolic",
  };

  // DeviceButton method to connect device
  function toggle_device(device: Bluetooth.Device) {
    print("Toggling device", device.get_name());
    if (bluetooth.adapter.powered) {
      if (!device.paired) {
        device.trusted = true;
        device.pair();
        device.connect_device(null);
      } else if (!device.connected) {
        device.connect_device(null);
      } else {
        device.disconnect_device(null);
      }
    }
  }

  function DeviceButton({ device }: { device: Bluetooth.Device }): JSX.Element {
    return (
      <button
        onButtonPressed={() =>
          !device.connecting ? toggle_device(device) : null
        }
        cssClasses={bind(device, "connected").as((c) =>
          c ? ["connected"] : [""]
        )}
      >
        <box spacing={4}>
          <image
            iconName={custom_icons[device.get_icon()] || device.get_icon()}
          />
          <label label={device.get_name().split(" ")[0]} />
        </box>
      </button>
    );
  }

  const device_list = bind(bluetooth, "devices").as((devices) =>
    devices
      .filter((device) => device.name && device.icon)
      .sort((a, b) => {
        if (a.connected && !b.connected) return -1;
        if (!a.connected && b.connected) return 1;
        if (a.paired && !b.paired) return -1;
        if (!a.paired && b.paired) return 1;
        return 0;
      })
      .map((device) => <DeviceButton device={device} />)
  );

  function scan() {
    if (!bluetooth.adapter.discovering && bluetooth.adapter.powered) {
      bluetooth.adapter.start_discovery();
      timeout(1000, () => bluetooth.adapter.stop_discovery());
    }
  }

  return (
    <ScrolledWindow
      hscrollbarPolicy={Gtk.PolicyType.NEVER}
      name={"bluetooth"}
      cssClasses={["bluetoothList"]}
    >
      <box orientation={Gtk.Orientation.VERTICAL} spacing={4}>
        <label label={"Bluetooth Devices"} halign={Gtk.Align.START} />
        {device_list}
      </box>
    </ScrolledWindow>
  );
}
