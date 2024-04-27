import Image from 'next/image';

export default async function UserAvatar({ image }: { image: string }) {
  return <Image src={image} alt="User Avatar" width={15} height={15} />;
}
