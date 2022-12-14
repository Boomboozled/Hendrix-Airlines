import styled, {keyframes} from 'styled-components';

export const CaptainHendrixImg = styled.img`
  height: 800px;
  bottom: 0;
  position: absolute;
  left: 50px;
`;

export const ChatBubbleImg = styled.img`
  position: relative;
  height: 700px;
  //width: 1000px;
  left: 90px;
  top: 35px;
`;

export const BgImg = styled.img`
  height: 100%;
  width: 100%;
  position: absolute;
  z-index: -1;
  object-fit: cover;
  filter: brightness(75%);
`;

export const AboutContainer = styled.div`
  display: flex;
  flex-direction: row;
  gap: 100px;
`;

const rgbAnimation = keyframes`
  0% {
    background-color: rgba(0, 255, 255, 1);
  }
  16.6% {
    background-color: rgba(238, 147, 236, 1);
  }
  33.2% {
    background-color: #90d9b1;
  }
  49.4% {
    background-color: #e1535b;
  }
  65.6% {
    background-color: #eaca7b;
  }
  81.8% {
    background-color: #cea65a;
  }
  100% {
    background-color: #66ccae;
  }
`;


export const AudioButton = styled.button`
  background: #49A9E6;
  white-space: nowrap;
  padding: 13px 28px;
  color: black;
  font-size: 16px;
  outline: none;
  border-style: solid;
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  text-decoration: none;
  border-radius: 20px;
  position: absolute;
  left: 200px;
  transition: 0.2s ease-in-out;
  top: 300px;
  z-index: 1;
  
  /* &:hover {
    background: white;
    transition: 0.2s ease-in-out;
  } */
  animation: ${rgbAnimation} 40s infinite;

`;

