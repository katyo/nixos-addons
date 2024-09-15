# ViactoriaMetrics datasource plugin for Grafana

## Usage

```nix
{
    services.grafana = {
        settings.plugins.allow_loading_unsigned_plugins = "victoriametrics-datasource";
        declarativePlugins = with pkgs; [ victoriametrics-datasource-bin ];
    };
}
```

## Configuration

```nix
{
    services.grafana.provision.datasources.settings.datasources = [
        {
            name  = "VictoriaMetrics";
            type = "victoriametrics-datasource";
            access = "proxy";
            url = "http://localhost:8428";
        }
    ];
];
```
