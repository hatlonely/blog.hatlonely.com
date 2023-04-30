image:
  repository: registry.cn-shanghai.aliyuncs.com/hatlonely/blog
  pullPolicy: IfNotPresent
  tag: "${VERSION}"

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
