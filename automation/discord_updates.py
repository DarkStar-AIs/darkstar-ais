"""Post GitHub website updates to the Darkstar AI Discord webhook."""
import json
import os
import sys
import urllib.request
from pathlib import Path

WEBHOOK = os.environ.get("DISCORD_WEBHOOK_URL", "").strip()
EVENT = os.environ.get("GITHUB_EVENT_NAME", "")
REPOSITORY = os.environ.get("GITHUB_REPOSITORY", "DarkStar-AIs/darkstar-ais")
SITE = "https://darkstar-ai.pages.dev"
if not WEBHOOK:
    print("No DISCORD_WEBHOOK_URL secret configured; skipping.")
    sys.exit(0)
if not WEBHOOK.startswith(("https://discord.com/api/webhooks/", "https://discordapp.com/api/webhooks/")):
    sys.exit("Invalid Discord webhook URL")
event_path = Path(os.environ["GITHUB_EVENT_PATH"])
event = json.loads(event_path.read_text(encoding="utf-8"))
if EVENT == "push":
    commits = event.get("commits", [])
    if not commits:
        print("No commits to announce")
        sys.exit(0)
    changed = set()
    for commit in commits:
        changed.update(commit.get("added", []))
        changed.update(commit.get("modified", []))
        changed.update(commit.get("removed", []))
    changed = {p for p in changed if not p.startswith((".github/", "automation/"))}
    if not changed:
        print("Only automation files changed; skipping")
        sys.exit(0)
    titles = [c.get("message", "Website update").splitlines()[0][:120] for c in commits]
    summary = "\n".join("• " + t for t in titles[:5])
    if len(titles) > 5:
        summary += f"\n• ...and {len(titles)-5} more changes"
    atlas = any("atlas" in p.lower() for p in changed)
    title = "🤖 ATLAS Update" if atlas else "🌌 Darkstar AI Website Update"
    description = f"{summary}\n\n[Visit Darkstar AI]({SITE})"
    link = event.get("compare") or f"https://github.com/{REPOSITORY}/commits/main"
elif EVENT == "release":
    release = event.get("release", {})
    if event.get("action") != "published":
        sys.exit(0)
    title = "🚀 New Darkstar AI Release"
    name = release.get("name") or release.get("tag_name") or "New release"
    description = f"**{name[:180]}**\n\n{(release.get('body') or 'A new release is available.')[:1400]}"
    link = release.get("html_url") or f"https://github.com/{REPOSITORY}/releases"
else:
    print("Unsupported event")
    sys.exit(0)
payload = {
    "username": "Darkstar AI Updates",
    "allowed_mentions": {"parse": []},
    "embeds": [{
        "title": title,
        "description": description[:3800],
        "url": link,
        "color": 5793266,
        "footer": {"text": "Darkstar AI • Automatic updates"}
    }]
}
request = urllib.request.Request(WEBHOOK, data=json.dumps(payload).encode("utf-8"),
    headers={"Content-Type": "application/json", "User-Agent": "DarkstarAI-AutoUpdates/1.0"},
    method="POST")
try:
    with urllib.request.urlopen(request, timeout=20) as response:
        print("Discord notification sent:", response.status)
except Exception as exc:
    print("Discord notification failed:", exc)
    sys.exit(1)
