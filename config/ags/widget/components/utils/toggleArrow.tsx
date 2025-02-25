import { Variable } from "astal";
import { Gtk, hook } from "astal/gtk4";

export default function ToggleArrow(id: string) {
  var rotating = false;
  const arrow_open = Variable<boolean>(false);
  const css = Variable<string>("");
  var interval: any;
  var deg = 0;
  var delay = 2;
  const cssProvider = new Gtk.CssProvider();

  function rotate_arrow() {
    if (!rotating && deg < 90) {
      rotating = true;
      interval = setInterval(() => {
        deg += 1;
        css.set(`-gtk-icon-transform: rotate(${deg}deg);`);
        if (deg >= 90) {
          clearInterval(interval);
          rotating = false;
          arrow_open.set(true);
        }
      }, delay);
    } else if (!rotating && deg >= 90) {
      rotating = true;
      interval = setInterval(() => {
        deg -= 1;
        css.set(`-gtk-icon-transform: rotate(${deg}deg);`);
        if (deg <= 0) {
          clearInterval(interval);
          rotating = false;
          arrow_open.set(false);
        }
      }, delay);
    }
  }

  return {
    arrow: (
      <image
        cssClasses={[`arrow${id}`]}
        iconName={"arrow-symbolic"}
        setup={(self) => {
          self
            .get_style_context()
            .add_provider(cssProvider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
          hook(self, css(), () => {
            cssProvider.load_from_string(`.arrow${id} { ${css().get()} }`);
          });
        }}
      />
    ),
    rotate_arrow,
    arrow_open,
  };
}
