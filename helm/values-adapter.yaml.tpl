image:
  repository: registry.cn-shanghai.aliyuncs.com/hatlonely/blog
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: "v0.0.0-1-gf01af86"

imagePullSecrets:
  - name: "${PULL_SECRET_NAME}"

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: "${HOST}"
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls:
    - secretName: "${SECRET_NAME}"
      hosts:
        - "${HOST}"
