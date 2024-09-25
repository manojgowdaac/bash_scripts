#!/bin/bash
#
#creating hosted zone in ROUTE 53
#
#Function to list all hosted zones in table form 
list_hosted_zones() {
    aws route53 list-hosted-zones --output table
}

# Function to create a hosted zone
create_hosted_zone() {
    local domain_name=$1
    local vpc_id=$2
    local region=$3

    if [ -z "$vpc_id" ]; then
        aws route53 create-hosted-zone --name "$domain_name" --caller-reference "$(date +%s)" --output json
    else
        aws route53 create-hosted-zone --name "$domain_name" --caller-reference "$(date +%s)" \
            --vpc VPCRegion="$region",VPCId="$vpc_id" --hosted-zone-config PrivateZone=true --output json
    fi
}

# Function to associate a VPC with an existing hosted zone
associate_vpc_with_hosted_zone() {
    local hosted_zone_id=$1
    local vpc_id=$2
    local region=$3

    aws route53 associate-vpc-with-hosted-zone --hosted-zone-id "$hosted_zone_id" \
        --vpc VPCRegion="$region",VPCId="$vpc_id" --comment "Associating VPC with hosted zone"
}

# Function to delete a hosted zone
delete_hosted_zone() {
    local hosted_zone_id=$1
    aws route53 delete-hosted-zone --id "$hosted_zone_id"
}

# Display usage information
usage() {
    echo "Usage: $0 {list|create|associate|delete} [parameters]"
    echo "Commands:"
    echo "  list                                    - List all hosted zones"
    echo "  create DOMAIN_NAME [VPC_ID REGION]      - Create a hosted zone (optionally private and associated with a VPC)"
    echo "  associate HOSTED_ZONE_ID VPC_ID REGION  - Associate a VPC with a hosted zone"
    echo "  delete HOSTED_ZONE_ID                   - Delete a hosted zone"
    exit 1
}

# Main script logic
case "$1" in
    list)
        list_hosted_zones
        ;;
    create)
        if [ -z "$2" ]; then
            usage
        fi
        create_hosted_zone "$2" "$3" "$4"
        ;;
    associate)
        if [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
            usage
        fi
        associate_vpc_with_hosted_zone "$2" "$3" "$4"
        ;;
    delete)
        if [ -z "$2" ]; then
            usage
        fi
        delete_hosted_zone "$2"
        ;;
    *)
        usage
        ;;
esac

