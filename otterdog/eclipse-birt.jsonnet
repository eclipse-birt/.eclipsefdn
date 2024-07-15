local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-birt') {
  settings+: {
    description: "",
    name: "Eclipse BIRT™ (Business Intelligence and Reporting Tools)",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/birt/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('birt') {
      allow_merge_commit: true,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse BIRT™ The open source reporting and data visualization project. ",
      has_discussions: true,
      has_wiki: false,
      homepage: "http://www.eclipse.org/birt",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://notify.travis-ci.org') {
          events+: [
            "create",
            "delete",
            "issue_comment",
            "member",
            "public",
            "pull_request",
            "push",
            "repository"
          ],
        },
      ],
    },
    orgs.newRepo('birt-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      has_discussions: true,
      private_vulnerability_reporting_enabled: true,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: null,
          requires_conversation_resolution: true,
          requires_pull_request: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
  ],
}
