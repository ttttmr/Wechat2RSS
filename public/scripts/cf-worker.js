const SECRET = "";

function error(msg) {
  return new Response(msg instanceof Error ? msg.message : msg, {
    status: 403,
  });
}

async function wfetch(url, opt) {
  if (!opt) {
    opt = {};
  }
  opt.headers["Referer"] = "https://mp.weixin.qq.com";
  opt.headers["User-Agent"] =
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.0.0 Safari/537.36";
  return await fetch(url, opt);
}

async function hmachex(message) {
  const encoder = new TextEncoder();
  const keyData = encoder.encode(SECRET);
  const messageData = encoder.encode(message);
  const key = await crypto.subtle.importKey(
    "raw",
    keyData,
    { name: "HMAC", hash: { name: "SHA-256" } },
    true,
    ["sign"]
  );
  const signature = await crypto.subtle.sign("HMAC", key, messageData);
  return Array.from(new Uint8Array(signature))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

async function vproxy(docUrl, vid) {
  const doc = await wfetch(docUrl);
  const html = await doc.text();
  const reg = new RegExp(vid + `'[\\s\\S]+?(mpvideo\\.qpic\\.cn/.+?)'`);
  const match = reg.exec(html);
  if (match) {
    const vurl = "https://" + match[1].replaceAll("\\x26amp;", "&");
    return await wfetch(vurl, {
      headers: {
        origin: "https://mp.weixin.qq.com",
      },
    });
  }
  return error("Video not found");
}

async function main(req, env) {
  try {
    if (req.method !== "GET") {
      return error("Method not allowed");
    }
    const u = new URL(req.url);
    const url = u.searchParams.get("u");
    const key = u.searchParams.get("k");
    const vid = u.searchParams.get("v") || "";
    if (!url || !key || key.length !== 8) {
      return error("Params is invalid");
    }
    const wxUrl = new URL(url);
    if (
      wxUrl.hostname !== "mmbiz.qpic.cn" &&
      wxUrl.hostname !== "res.wx.qq.com" &&
      wxUrl.hostname !== "mpvideo.qpic.cn" &&
      wxUrl.hostname !== "mp.weixin.qq.com"
    ) {
      return error("Url is invalid");
    }
    const hmac = await hmachex(url + vid);
    if (hmac.substring(0, 8) !== key) {
      return error("Key is invalid");
    }
    if (vid) {
      return await vproxy(url, vid);
    } else {
      return await wfetch(url);
    }
  } catch (e) {
    return error(e.message);
  }
}

export default {
  fetch: main,
};
