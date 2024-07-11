import jwt from "jsonwebtoken";

interface DecodedToken {
  user_id: string;
  role: string;
  exp: number;
  iat: number;
}

export const decryptToken = (
  token: string,
  secret: string
): DecodedToken | null => {
  try {
    const decoded = jwt.verify(token, secret) as DecodedToken;
    return decoded;
  } catch (error) {
    console.error("Failed to decrypt token:", error);
    return null;
  }
};
