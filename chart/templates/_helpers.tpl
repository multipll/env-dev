{{/*
Multipll umbrella chart helpers
*/}}

{{/*
API domain: <apiPrefix>.<baseDomain>
e.g., api-dev.dev-internal-api.multipll.com
*/}}
{{- define "multipll.apiDomain" -}}
{{ .Values.global.routing.apiPrefix }}.{{ .Values.global.routing.baseDomain }}
{{- end }}

{{/*
UI domain: <uiPrefix>.<baseDomain>
e.g., ui-dev.dev-internal-api.multipll.com
*/}}
{{- define "multipll.uiDomain" -}}
{{ .Values.global.routing.uiPrefix }}.{{ .Values.global.routing.baseDomain }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "multipll.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: multipll
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
