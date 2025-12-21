<?php

function getAccessToken() {
    $keyFile = '/home/u603532533/private/skolar-52a91-e2558f0e5c1f.json';
    $jsonKey = json_decode(file_get_contents($keyFile), true);

    $now = time();

    $header = rtrim(strtr(base64_encode(json_encode([
        'alg' => 'RS256',
        'typ' => 'JWT'
    ])), '='));

    $claim = rtrim(strtr(base64_encode(json_encode([
        'iss'   => $jsonKey['client_email'],
        'scope' => 'https://www.googleapis.com/auth/firebase.messaging',
        'aud'   => 'https://oauth2.googleapis.com/token',
        'iat'   => $now,
        'exp'   => $now + 3600,
    ])), '='));

    openssl_sign("$header.$claim", $signature, $jsonKey['private_key'], OPENSSL_ALGO_SHA256);
    $jwt = "$header.$claim." . rtrim(strtr(base64_encode($signature), '='), '=');

    $ch = curl_init('https://oauth2.googleapis.com/token');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => http_build_query([
            'grant_type' => 'urn:ietf:params:oauth:grant-type:jwt-bearer',
            'assertion'  => $jwt
        ])
    ]);

    $res = json_decode(curl_exec($ch), true);
    curl_close($ch);

    return $res['access_token'] ?? null;
}

function sendFCM($title, $body, $topic, $pageId = "", $pageName = "") {

    $token = getAccessToken();
    if (!$token) return false;

    $projectId = 'YOUR_PROJECT_ID';

    $payload = [
        "message" => [
            "topic" => $topic,
            "notification" => [
                "title" => $title,
                "body" => $body
            ],
            "data" => [
                "pageid" => $pageId,
                "pagename" => $pageName
            ]
        ]
    ];

    $ch = curl_init("https://fcm.googleapis.com/v1/projects/$projectId/messages:send");
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_HTTPHEADER => [
            "Authorization: Bearer $token",
            "Content-Type: application/json"
        ],
        CURLOPT_POSTFIELDS => json_encode($payload)
    ]);

    $result = curl_exec($ch);
    curl_close($ch);

    return $result;
}
