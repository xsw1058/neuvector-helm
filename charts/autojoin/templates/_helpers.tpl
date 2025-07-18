{{/* vim: set filetype=mustache: */}}
{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "neuvector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "neuvector.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "neuvector.hostname" -}}
  {{- if .Values.exporter.ctrl_join_addr }}
    {{- printf "%s" .Values.exporter.ctrl_join_addr }}
  {{- else }}
    {{- printf "%s%s%s" .Values.exporter.ctrl_join_addr_prefix .Values.exporter.pass_store_id .Values.exporter.ctrl_join_addr_suffix}}
  {{- end }}
{{- end -}}


{{- define "neuvector.random" -}}
  {{- if .Values.schedule }}
    {{- printf "%s" .Values.schedule }}
  {{- else }}
    {{- $randSec := randNumeric 10 | int }}
    {{- $rangeSec := sub 0 59 }}
    {{- $randomSec := add 0 (mod $randSec $rangeSec) }}
    {{- $randMin := randNumeric 10 | int }}
    {{- $rangeMin := sub 1 5 }}
    {{- $randomMin := add 1 (mod $randMin $rangeMin) }}
    {{- printf "%v %v * * *" $randomSec $randomMin }}
  {{- end }}
{{- end -}}