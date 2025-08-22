/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    domains: [
      'milsat-fileuploads.s3.amazonaws.com',
    ],
    unoptimized: true,
  },
output: 'standalone',
// output:"export",
useFileSystemPublicRoutes: true
}

module.exports = nextConfig