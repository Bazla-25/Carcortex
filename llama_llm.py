from langchain import LLMChain
from langchain.agents import create_sql_agent
from langchain.agents.agent_toolkits import SQLDatabaseToolkit
from langchain_community.llms.ollama import Ollama
from langchain.prompts import PromptTemplate
from Carcortex.DbConnection import db 
from langchain_core.output_parsers import StrOutputParser
import re

def extract_answer(llm_response):
    # Use regex to find the "Answer:" section and capture everything after it
    match = re.search(r"Answer:\s*(.*)", llm_response, re.DOTALL)  # re.DOTALL allows . to match newlines
    if match:
        return match.group(1).strip()
    else:
        return "No answer found."

def generate_sql_query(user_input: str) -> str:

    custom_prompt = PromptTemplate(
    input_variables=["input"],
    template="""
    You are a Postgres expert. Given an input question, first create a syntactically correct Postgres query to run, then look at the results of the query and return the answer to the input question.

    Unless the user specifies in the question a specific number of examples to obtain, query for at most 5 results using the LIMIT clause as per Postgres. You can order the results to return the most informative data in the database.

    Never query for all columns from a table. You must query only the columns that are needed to answer the question. Wrap each column name in double quotes (") to denote them as delimited identifiers.

    Pay attention to use only the column names you can see in the tables below. Be careful to not query for columns that do not exist.
    Also, pay attention to which column is in which table.
    Use the following format:
    Question: <Question here>
    SQLQuery: <SQL Query to run>
    SQLResult: <Result of the SQLQuery>
    Answer: <Final answer here>
    
    When given a task or a question, respond with the appropriate SQL query and the result.
    Task:{input}

    """
    )
#phi3.5
    llm = Ollama(model="llama3.2")
    prompt = custom_prompt
    output_parser = StrOutputParser()

    # Define the LLMChain
    #llm_chain = LLMChain(prompt=prompt, llm=llm)
    llm_chain = prompt | llm | output_parser

# Call the LLM with user input and database schema as reference
    sql_query = llm_chain.invoke({"input": user_input, "db_schema": db})
    print(sql_query)
    result = extract_answer(sql_query)
    # toolkit = SQLDatabaseToolkit(db=db,llm=llm)
    # agent_executor = create_sql_agent(
    #     llm=llm,
    #     toolkit = toolkit,
    #     prompt=custom_prompt,
    #     verbose=True
    # )
    # sql_query = agent_executor.invoke(input=user_input, handle_parsing_errors=True)
    # #sql_query = LLMChain(prompt=prompt, llm=llm).run({"task": user_input})
    return result


# prompt_user = "I need specs of car ""FORD"" "
# result = generate_sql_query(prompt_user)
# print("result",result)


    # custom_prompt = PromptTemplate(
    # input_variables=["input", "tools", "tool_names", "agent_scratchpad"],
    # template="""
    # You are a Postgres expert. Given an input question, first create a syntactically correct Postgres query to run, then look at the results of the query and return the answer to the input question.

    # Unless the user specifies in the question a specific number of examples to obtain, query for at most 5 results using the LIMIT clause as per Postgres. You can order the results to return the most informative data in the database.

    # Never query for all columns from a table. You must query only the columns that are needed to answer the question. Wrap each column name in double quotes (") to denote them as delimited identifiers.

    # Pay attention to use only the column names you can see in the tables below. Be careful to not query for columns that do not exist.
    # Also, pay attention to which column is in which table.
    # Use the following format:
    # Question: <Question here>
    # SQLQuery: <SQL Query to run>
    # SQLResult: <Result of the SQLQuery>
    # Answer: <Final answer here>
    # You have access to the following tools: {tool_names}.
    
    # When given a task or a question, respond with the appropriate SQL query and the result.
    # If the user's request is not clear, ask for clarification.

    # Task: {input}
    # Available Tools: {tools}
    # Scratchpad: {agent_scratchpad}  
    # """
    # )