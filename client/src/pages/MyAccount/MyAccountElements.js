import styled from "styled-components";
import Footer from "../../components/Footer";


export const PageWrap = styled.div`
  display: flex;
  flex-direction: column;
  height: 100vh;
`;

export const PageBody = styled.div`
  display: flex;
  flex-direction: column;
  flex: 1 0 auto;
  align-items: center;
  justify-content: center;
  gap: 15px;
`;

export const BgImg = styled.img`
  height: 100%;
  width: 100%;
  position: absolute;
  z-index: -1;
  object-fit: cover;
  filter: brightness(90%);
`;

export const TabsContainer = styled.div`
  display: flex;
  flex-direction: row;
  gap: 10px;
`;

export const AccountTab = styled.button`
  border-style: solid;
  background-color: ${({currTab}) => (currTab ? '#ffffff' : '#e6f7ff')};
  height: 70px;
  width: 250px;
  font-size: 18pt;
  font-weight: bold;
  border-radius: 25px;
  //text-decoration: underline;
  cursor: ${({currTab}) => (currTab ? 'default' : 'pointer')};
  
  &:hover {
    transition: all 0.2s ease-in-out;
    background: white;
  }
`;

export const InfoRow = styled.div`
  display: flex;
  flex-direction: row;
  align-items: end;
  gap: 16px;
  //height: 47px;
  justify-content: center;
`;

export const InfoHeader = styled.h1`
  font-size: 18pt;
  color: black;
`;

export const InfoText = styled.p`
  font-size: 14pt;
  color: black;
  margin-bottom: 3px;
`;

export const SignOutButton = styled.button`
  border-radius: 50px;
  background: #010606;
  white-space: nowrap;
  padding: 13px 28px;
  color: white;
  font-size: 16px;
  outline: none;
  border: none;
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: all 0.2s ease-in-out;
  text-decoration: none;
  width: 150px;
  margin-top: 10px;
  
  &:hover {
    transition: all 0.2s ease-in-out;
    background: #49A9E6;
  }
`;

// export const AccountDetailsContainer = styled.div`
//   display: flex;
//   flex-direction: column;
//   height: 550px;
//   width: 1200px;
//   border-style: groove;
//   background-color: #e6f7ff;
//   align-items: center;
//   justify-content: center;
//   gap: 20px;
// `;

export const AccountDetailsContainer = styled.div`
  display: flex;
  flex-direction: column;
  height: 550px;
  width: 1200px;
  align-items: center;
  justify-content: center;
  gap: 20px;
`;

export const CenterBox = styled.div`
  height: 550px;
  width: 1200px;
  //border-style: groove;
  background-color: #e6f7ff;
  border-radius: 20px;
`;

export const AccountFooter = styled(Footer)`
  flex-shrink: 0;
`;
