# env-dev

Dev environment deployment configuration for the Multipll platform.

## Structure

```
env-dev/
├── chart/
│   ├── Chart.yaml              # Umbrella chart with all services as OCI dependencies
│   ├── values.yaml             # Default values (toggles, routing defaults)
│   ├── values-dev.yaml         # Dev environment overrides
│   └── templates/
│       ├── _helpers.tpl        # Domain helpers
│       ├── ingress-api.yaml    # API ingress (path-based routing)
│       └── ingress-ui.yaml     # UI ingress (path-based routing)
├── values/                     # Per-service values (for single-service deploys)
├── env.json                    # Environment metadata
└── .github/workflows/
    └── deploy.yml
```

## Routing

All traffic goes through two umbrella-level ingresses:

**API** — `api-dev.dev-internal-api.multipll.com`
| Path | Service |
|------|---------|
| `/v1/auth/*` | auth |
| `/callback` | auth |
| `/v1/decisions/*` | auth |
| `/v1/admin/*` | auth |
| `/api/v1/coa/*` | coa |
| `/api/v1/org/*` | coa |
| `/v1/orgs/*` | kpi |

**UI** — `ui-dev.dev-internal-api.multipll.com`
| Path | Service |
|------|---------|
| `/admin/*` | dashboard-admin |
| `/cfo/*` | dashboard-cfo |

Per-environment domain prefixes:
| Environment | API | UI |
|-------------|-----|-----|
| dev | `api-dev.dev-internal-api.multipll.com` | `ui-dev.dev-internal-api.multipll.com` |
| staging | `api-staging.dev-internal-api.multipll.com` | `ui-staging.dev-internal-api.multipll.com` |
| production | `api.dev-internal-api.multipll.com` | `ui.dev-internal-api.multipll.com` |

Subchart ingresses are disabled — all routing is handled by the umbrella chart.

## Deploy

### Umbrella (default) — all services as one release
```bash
helm dependency update chart/
helm upgrade --install multipll chart/ -f chart/values-dev.yaml -n multipll-dev --create-namespace
```

### Single service — from OCI registry
Use workflow_dispatch with mode=single-service.

## Target

- Cluster: `aks-multipll-dev`
- Resource group: `rg-multipll-dev`
- Namespace: `multipll-dev`
- ACR: `multipllacrdev1`
- KeyVault: `multipll-keyvault-dev`
