from diagrams import Diagram, Cluster, Edge
from diagrams.aws.network import Route53, Route53HostedZone, CloudFront
from diagrams.aws.security import CertificateManager
from diagrams.aws.storage import S3
from diagrams.aws.management import Cloudwatch
from diagrams.aws.devtools import Codebuild
from diagrams.aws.general import User
from diagrams.programming.language import JavaScript, Python
from diagrams.onprem.vcs import Github
from diagrams.onprem.iac import Terraform
from diagrams.custom import Custom


graph_attr = {
    "bgcolor": "transparent",
    "pad": "0.5",
    "splines": "curved",
    "fontcolor": "white",
    "labelfontcolor": "white",
}

node_attr = {
    "fontcolor": "white",
}

edge_attr = {
    "fontcolor": "white",
    "labelfontcolor": "white",
}

cluster_attr = {
    "fontsize": "14",
    "bgcolor": "transparent",
    "style": "rounded",
    "color": "gray",
    "penwidth": "2.0",
    "fontcolor": "white",
}


def architecture_diagram():
    with Diagram("", outformat="png", filename="assets/architecture", show=False, graph_attr=graph_attr, node_attr=node_attr, edge_attr=edge_attr, direction="LR"):
        user = User("User")
        
        with Cluster("Domain Registrar", graph_attr=cluster_attr):
            porkbun = Custom("Porkbun", "../icons/porkbun.png")
        
        with Cluster("AWS", graph_attr=cluster_attr):
            with Cluster("DNS", graph_attr={"bgcolor": "transparent", "color": "#1976D2", "penwidth": "2.0"}):
                hosted_zone = Route53HostedZone("Route 53\nHosted Zone")
                a_record = Route53("A Record\n(Alias)")
                txt_record = Route53("TXT Record\n(SPF)")
            
            with Cluster("CDN & Caching", graph_attr={"bgcolor": "transparent", "color": "#F57C00", "penwidth": "2.0"}):
                cloudfront = CloudFront("CloudFront\nDistribution")
                cf_function = JavaScript("CloudFront\nFunction\n(URL Rewrite)")
                acm = CertificateManager("ACM\nSSL/TLS\nCertificate")
            
            with Cluster("Data Layer", graph_attr={"bgcolor": "transparent", "color": "gray", "penwidth": "2.0", "rankdir": "LR"}):
                with Cluster("Static Site Storage", graph_attr={"bgcolor": "transparent", "color": "#388E3C", "penwidth": "2.0"}):
                    s3 = S3("S3 Bucket\n(Private)")
                
                with Cluster("Monitoring & Analytics", graph_attr={"bgcolor": "transparent", "color": "#9C27B0", "penwidth": "2.0"}):
                    cloudwatch = Cloudwatch("CloudWatch\nDashboard")
        
        user >> Edge(label="DNS Query", fontcolor="white") >> hosted_zone
        porkbun >> Edge(label="Nameservers", fontcolor="white") >> hosted_zone
        hosted_zone >> a_record
        a_record >> Edge(label="HTTPS", fontcolor="white") >> cloudfront
        cloudfront >> Edge(label="SSL/TLS", fontcolor="white") >> acm
        cloudfront >> Edge(label="Rewrite URLs", fontcolor="white") >> cf_function
        cloudfront >> Edge(label="Origin Access\nControl (OAC)", fontcolor="white") >> s3
        s3 >> Edge(style="invis") >> cloudwatch
        cloudwatch >> Edge(label="Export\nLogs", fontcolor="white") >> s3
        
        hosted_zone >> txt_record


def cicd_diagram():
    with Diagram("", outformat="png", filename="assets/cicd", show=False, graph_attr=graph_attr, node_attr=node_attr, edge_attr=edge_attr, direction="LR"):

        with Cluster("Source Control", graph_attr=cluster_attr):
            repo = Github("GitHub\nRepository")
            gh_secrets = Github("GitHub Secrets")

        with Cluster("CI/CD Pipelines", graph_attr={**cluster_attr, "style": "invis"}):
            with Cluster("Infrastructure Pipeline", graph_attr={**cluster_attr, "color": "#FF6F00", "penwidth": "2.0"}):
                tf_workflow = Terraform("Build\nInfrastructure\nWorkflow")
                tf_plan = Terraform("Terraform\nPlan")
                tf_apply = Terraform("Terraform\nApply")

            with Cluster("Website Pipeline", graph_attr={**cluster_attr, "color": "#7B1FA2", "penwidth": "2.0"}):
                build_workflow = Codebuild("Build\nWebsite\nWorkflow")
                astro_build = JavaScript("Astro Build\n(Bun)")
                deploy = Codebuild("Deploy")

            with Cluster("Diagram Pipeline", graph_attr={**cluster_attr, "color": "#1976D2", "penwidth": "2.0"}):
                diagram_workflow = Github("Build\nDiagrams\nWorkflow")
                python_build = Python("Python\n(uv)")

        with Cluster("AWS", graph_attr=cluster_attr):
            s3_bucket = S3("S3 Bucket\n(Static Files)")
            cloudfront_dist = CloudFront("CloudFront\nDistribution")
            tf_state = S3("S3 Bucket\n(Terraform State)")
        
        repo >> Edge(label="Push to main\n(terraform/**)", fontcolor="white") >> tf_workflow
        tf_workflow >> tf_plan
        tf_plan >> Edge(label="If changes", fontcolor="white") >> tf_apply
        gh_secrets >> Edge(label="", fontcolor="white") >> tf_apply
        tf_apply >> Edge(label="Read/Write", fontcolor="white") >> tf_state
        tf_apply >> Edge(label="Provision", fontcolor="white") >> s3_bucket
        tf_apply >> Edge(label="Configure", fontcolor="white") >> cloudfront_dist
        
        repo >> Edge(label="Push to main\n(website/**)", fontcolor="white") >> build_workflow
        build_workflow >> astro_build
        astro_build >> deploy
        deploy >> Edge(label="Sync Files", fontcolor="white") >> s3_bucket
        deploy >> Edge(label="Invalidate Cache", fontcolor="white") >> cloudfront_dist

        repo >> Edge(label="Push to main\n(docs/**)", fontcolor="white") >> diagram_workflow
        diagram_workflow >> python_build


def main():
    architecture_diagram()
    cicd_diagram()


if __name__ == "__main__":
    main()
