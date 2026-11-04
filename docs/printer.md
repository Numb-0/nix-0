# Printers (CUPS)

## Kyocera ECOSYS MA5500ifx

No driver package needed: the printer supports IPP Everywhere (driverless).

**Note:** plain IPP on port `631` is disabled on the printer (`server-error-service-unavailable`),
only IPP over SSL on port `443` answers. Use `ipps://...:443`, not `ipp://`.

### Setup

Add the printer (CUPS builds the PPD by querying the printer):

```bash
sudo lpadmin -p Kyocera_MA5500ifx -E -v ipps://192.168.42.20:443/ipp/print -m everywhere
```

Set A4 as default paper size:

```bash
sudo lpadmin -p Kyocera_MA5500ifx -o PageSize=A4
```

Print a test page:

```bash
lp -d Kyocera_MA5500ifx /etc/os-release
```

### Troubleshooting

`lpadmin: Connection timed out` → wrong endpoint, check which one answers:

```bash
ipptool -T 20 -t ipp://192.168.42.20/ipp/print get-printer-attributes.test
ipptool -T 20 -t ipps://192.168.42.20:443/ipp/print get-printer-attributes.test
```

`status-code = successful-ok` means that URI works.

Alternatively enable plain IPP on the printer: Command Center RX (`https://192.168.42.20`)
→ Network Settings → Protocol → IPP → On.

Fallback if `-m everywhere` fails (generic driverless driver, no printer query):

```bash
sudo lpadmin -p Kyocera_MA5500ifx -E -v ipps://192.168.42.20:443/ipp/print -m drv:///cupsfilters.drv/pwgrast.ppd
```

The CUPS web UI (`http://localhost:631`) only offers "IPP Everywhere" as Make when
the connection URI is `ipp://`/`ipps://`, not `socket://`.

### Useful commands

```bash
lpstat -v                          # list printers and their URIs
lpoptions -p Kyocera_MA5500ifx -l  # available options (duplex, trays, ...)
lpstat -o                          # print queue
cancel -a Kyocera_MA5500ifx        # clear the queue
sudo lpadmin -x Kyocera_MA5500ifx  # remove the printer
```

### Declarative (NixOS) note

`hardware.printers.ensurePrinters` with `model = "everywhere"` runs `lpadmin` at every
CUPS start and fails when the printer is unreachable (e.g. laptop off that network),
breaking `cups.service`. If going declarative, copy the generated
`/etc/cups/ppd/Kyocera_MA5500ifx.ppd` into the repo, ship it via
`services.printing.drivers`, and use it as `model` instead.
