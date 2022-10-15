{{/*
Expand the name of the chart.
*/}}
{{- define "springservice.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "springservice.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Values.name }}
{{- .Values.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Values.name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "springservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "springservice.labels" -}}
helm.sh/chart: {{ include "springservice.chart" . }}
{{ include "springservice.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "springservice.selectorLabels" -}}
app.kubernetes.io/name: {{ include "springservice.name" . }}
app.kubernetes.io/instance: {{ .Values.name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "springservice.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "springservice.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}