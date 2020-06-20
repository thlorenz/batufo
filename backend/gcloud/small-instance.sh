INSTANCE_NAME=batufo-small

gcloud beta compute --project=batufo-280915 instances create "$INSTANCE_NAME" \
    --zone=us-central1-a                                                      \
    --machine-type=g1-small                                                   \
    --subnet=default                                                          \
    --network-tier=PREMIUM                                                    \
    --maintenance-policy=MIGRATE                                              \
    --service-account=387267655148-compute@developer.gserviceaccount.com      \
    --scopes=https://www.googleapis.com/auth/cloud-platform                   \
    --tags=http-server,https-server                                           \
    --image=debian-10-buster-v20200618                                        \
    --image-project=debian-cloud                                              \
    --boot-disk-size=10GB                                                     \
    --boot-disk-type=pd-standard                                              \
    --boot-disk-device-name="$INSTANCE_NAME"                                  \
    --no-shielded-secure-boot                                                 \
    --shielded-vtpm                                                           \
    --shielded-integrity-monitoring                                           \
    --reservation-affinity=any

gcloud compute --project=batufo-280915 firewall-rules create default-allow-http \
    --direction=INGRESS --priority=1000 --network=default --action=ALLOW        \
    --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server

gcloud compute --project=batufo-280915 firewall-rules create default-allow-https \
    --direction=INGRESS --priority=1000 --network=default --action=ALLOW         \
    --rules=tcp:443 --source-ranges=0.0.0.0/0 --target-tags=https-server
